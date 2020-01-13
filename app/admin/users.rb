ActiveAdmin.register User do

  permit_params :last_name, :first_name, :tel_no, :email, :img, :profile
  
  index do
    column :id
    column :last_name
    column :first_name
    column :tel_no
    column :email
    actions
  end
end
