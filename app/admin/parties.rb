ActiveAdmin.register Party do
 
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :hex_colour
      f.input :website
      f.input :image
    end

    f.buttons  
  end

  index do
    column :id
    column 'Name', :sortable => :name do |party|
      (link_to party.name, admin_party_path(party)).html_safe + " " +
      (link_to 'edit', edit_admin_party_path(party)).html_safe
    end
    column 'Picture' do |party|
      image_tag party.image.url(:thumb)  unless party.image_file_name.blank?
    end 
    column :hex_colour do |party|
      content_tag(:div, '', :style => "background-color: #{party.hex_colour}; height: 50px; width: 100px;")  unless party.hex_colour.blank?
    end
    column :website do |party|
      link_to 'website', party.website  unless party.website.blank?
    end
  end
 
end
