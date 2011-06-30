ActiveAdmin.register Politician do
  
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :constituency
      f.input :incumbent
      f.input :party
      f.input :image
    end

    f.inputs "Contact" do
      f.input :email
      f.input :phone_number
      f.input :office_address
    end

    f.inputs "Online (Full URL including http://)" do
      f.input :website
      f.input :incumbent_website
      f.input :facebook
      f.input :twitter
      f.input :youtube
    end

    f.buttons  
  end

  index do
    column :id
    column 'Name', :sortable => :name do |politician|
      (link_to politician.name, admin_politician_path(politician)).html_safe + " " +
      (link_to 'edit', edit_admin_politician_path(politician)).html_safe
    end
    column 'Picture' do |politician|
      image_tag politician.image.url(:thumb)  unless politician.image_file_name.blank?
    end
    column :incumbent
    column 'Online' do |politician|
      div do
        div do
          span do
            link_to 'w', politician.website
          end  unless politician.website.blank?
          span do
            link_to 'i', politician.incumbent_website
          end  unless politician.incumbent_website.blank?
        end  unless politician.website.blank? && politician.incumbent_website.blank?
        span do
          mail_to politician.email, image_tag('/images/mail_active.jpg')
        end  unless politician.email.blank?
        span do
          link_to image_tag('/images/facebook_active.jpg'), politician.facebook
        end  unless politician.facebook.blank?
        span do
          link_to image_tag('/images/twitter_active.jpg'), politician.twitter 
        end  unless politician.twitter.blank?
        span do
          link_to image_tag('/images/youtube_active.jpg'), politician.youtube
        end  unless politician.youtube.blank?
      end
    end
    column :office_address
    column :phone_number
    column :party
    column :constituency
  end

  sidebar :create_resources, :only => :show do 
    ul do
      li link_to('New Politician', new_admin_politician_path)
      li link_to('New Constituency', new_admin_constituency_path)
      li link_to('New Party', new_admin_party_path)
    end
  end

end
