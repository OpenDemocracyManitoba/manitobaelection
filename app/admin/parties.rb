ActiveAdmin.register Party do
 
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :long_name
      f.input :hex_colour
      f.input :image
      f.input :notes
    end

    f.inputs "Contact" do
      f.input :email
      f.input :phone_number
      f.input :address
    end

    f.inputs "Online (Full URL including http://)" do
      f.input :website
      f.input :facebook
      f.input :twitter
      f.input :youtube
    end

    f.buttons  
  end

  index do
    column :id
    column 'Name', :sortable => :name do |party|
      (link_to party.name, admin_party_path(party)).html_safe + " " +
      (link_to 'edit', edit_admin_party_path(party)).html_safe
    end
    column :long_name
    column 'Picture' do |party|
      image_tag party.image.url(:thumb)  unless party.image_file_name.blank?
    end 
    column :hex_colour do |party|
      content_tag(:div, '', :style => "background-color: #{party.hex_colour}; height: 50px; width: 100px;")  unless party.hex_colour.blank?
    end
    column 'Online' do |party|
      div do
        span do
          link_to 'w', party.website
        end  unless party.website.blank?
        span do
          mail_to party.email, image_tag('/images/mail_active.jpg')
        end  unless party.email.blank?
        span do
          link_to image_tag('/images/facebook_active.jpg'), party.facebook
        end  unless party.facebook.blank?
        span do
          link_to image_tag('/images/twitter_active.jpg'), party.twitter 
        end  unless party.twitter.blank?
        span do
          link_to image_tag('/images/youtube_active.jpg'), party.youtube
        end  unless party.youtube.blank?
      end
    end
    column :address
    column :phone_number
  end

  sidebar :create_resources, :only => :show do 
    ul do
      li link_to('New Party', new_admin_party_path)
      li link_to('New Politician', new_admin_politician_path)
      li link_to('New Constituency', new_admin_constituency_path)
    end
  end
 
end
