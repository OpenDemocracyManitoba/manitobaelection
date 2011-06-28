ActiveAdmin.register Constituency do
 
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :image
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
 
 
end
