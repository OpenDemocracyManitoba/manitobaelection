ActiveAdmin.register Politician do
  
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :constituency
      f.input :party
      f.input :image
    end

    f.inputs "Contact" do
      f.input :email
      f.input :phone_number
      f.input :office_address
    end

    f.inputs "Online" do
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
    column 'Name' do |politician|
      link_to politician.name, admin_politician_path(politician)
    end
    column 'Picture' do |politician|
      image_tag politician.image.url(:thumb)
    end
    column :incumbent
    column :website
    column :incumbent_website
    column :facebook
    column :twitter
    column :youtube
    column :office_address
    column :phone_number
    column :email
    column :party
    column :constituency
  end

end
