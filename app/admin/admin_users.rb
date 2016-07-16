ActiveAdmin.register User, :as => "Bicimensajeros" do

  actions :all, :except => [:show]

  permit_params :name, :nickname, :password, :password_confirmation, :email, :uid

  filter :nickname, :label => "usuario"
  filter :name, :label => "en_checkfront"
  
  config.sort_order = 'created_at_desc'


  controller do
    def create
      params[:user][:uid] = params[:user][:email]
      super
    end
    def update
      params[:user][:uid] = params[:user][:email]
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

  index :title => "Bicimensajeros" do
    column "Usuario", :nickname
    column "En_checkfront", :name
    actions :defaults => true
  end

  form do |f|
    f.inputs "Modificación de bicimensajeros" do
      f.input :nickname, label: "Usuario"
      f.input :name, label: "En_checkfront"
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
