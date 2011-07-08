ActiveAdmin.register Constituency do
 
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :image
      f.input :pdf_map_url
    end

    f.buttons  
  end

  index do
    column :id
    column 'Name', :sortable => :name do |constituency|
      (link_to constituency.name, admin_constituency_path(constituency)).html_safe + " " +
      (link_to 'edit', edit_admin_constituency_path(constituency)).html_safe
    end
    column 'Picture' do |constituency|
      image_tag constituency.image.url(:thumb)  unless constituency.image_file_name.blank?
    end 
  end

  sidebar :create_resources, :only => :show do 
    ul do
      li link_to('New Constituency', new_admin_constituency_path)
      li link_to('New Politician', new_admin_politician_path)
      li link_to('New Party', new_admin_party_path)
    end
  end
 
end
