ActiveAdmin.register Studio do

  permit_params :name, :fee, :img, :guitar_amp, :bass_amp, :drums, :keybords
  
  index do
    column :name
    column :fee
    column :img
    column :guitar_amp
    column :bass_amp
    column :drums
    column :keybords
    actions
  end
end
