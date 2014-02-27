require 'mailmech'

class List < ActiveRecord::Base
  has_many :subscriptions, :dependent => :destroy
  has_many :users, :through => :subscriptions
  belongs_to :beta
  attr_accessible :comment, :name, :pass, :server

  def admin_link
    "#{server}/admin/#{name}"
  end

  def sync_to_intern
    # Sync the external represantation to the internal "real" list
    # (which leaves the external list untouched!)
    mech = Mailmech.new(server,name,pass)

    subscribers = mech.subscribers

    users_created = []
    users_added   = []

    # Eliminate duplicates
    users.uniq!

    subscribers.map{|s| s.downcase }.each do |s|
      u = User.find_by_email(s)
      if  u
        if !users.include? u
          users << u
          users_added << u
        end
      else
        # Try alternate email
        u = User.find_by_alt_email(s)
        if  u
          if !users.include? u
            users << u
            users_added << u
          end
        else
          # puts "Create user for email #{s} !"
          u = User.new
          u.email = s
          u.note = "User created through\nList sync: #{name}"
          s =~ /(.*)@/
          u.last_name = $1 if $1
          u.save
          users_created << u
          users_added << u
          users << u
        end
      end
    end

    users_dropped = []
    users.each do |u|
      email = u.email ||= ""
      alt_email = u.alt_email ||= ""
      if !subscribers.include?(email.downcase) && !subscribers.include?(alt_email.downcase)
        users_dropped << u
      end

    end
    users_dropped.each do |u|
      users.delete u
    end

    Blog.info "#{logname} sync_to_intern called:"
    Blog.info "    Added: #{users_added.map{|u| u.logname}.join(', ')}"
    Blog.info "  Created: #{users_created.map{|u| u.logname}.join(', ')}"
    Blog.info "  Dropped: #{users_dropped.map{|u| u.logname}.join(', ')}"
    return {added: users_added, dropped: users_dropped, created: users_created}
  end

  def subscribe(user)
    mech = Mailmech.new(server,name,pass)
    mech.subscribe([user.email])
  end

  def unsubscribe(user)
    mech = Mailmech.new(server,name,pass)
    mech.delete([user.email])
  end

  def logname
    if name.nil? || name.empty? 
      return "List #{id}"
    else
      return "List #{id} (#{name})"
    end
  end
end

