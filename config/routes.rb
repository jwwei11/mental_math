Rails.application.routes.draw do



  # Routes for the Score resource:

  # CREATE
  match("/insert_score", { :controller => "scores", :action => "create", :via => "post"})
          
  # READ
  match("/scores", { :controller => "scores", :action => "index", :via => "get"})
  
  match("/scores/:id_from_path", { :controller => "scores", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_score/:id_from_path", { :controller => "scores", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_score/:id_from_path", { :controller => "scores", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Setting resource:

  # CREATE
  match("/insert_setting", { :controller => "settings", :action => "create", :via => "post"})
          
  # READ
  match("/settings", { :controller => "settings", :action => "index", :via => "get"})
  
  match("/settings/:id_from_path", { :controller => "settings", :action => "show", :via => "get"})

  match("/settings/:id_from_path/practice/:question_id", { :controller => "settings", :action => "practice", :via => "get"})
  
  # UPDATE
  
  match("/modify_setting/:id_from_path", { :controller => "settings", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_setting/:id_from_path", { :controller => "settings", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for signing up

  match("/user_sign_up", { :controller => "users", :action => "new_registration_form", :via => "get"})
  
  # Routes for signing in
  match("/user_sign_in", { :controller => "user_sessions", :action => "new_session_form", :via => "get"})
  
  match("/user_verify_credentials", { :controller => "user_sessions", :action => "add_cookie", :via => "post"})
  
  # Route for signing out
  
  match("/user_sign_out", { :controller => "user_sessions", :action => "remove_cookies", :via => "get"})
  
  # Route for creating account into database 

  match("/post_user", { :controller => "users", :action => "create", :via => "post" })
  
  # Route for editing account
  
  match("/edit_user", { :controller => "users", :action => "edit_registration_form", :via => "get"})
  
  match("/patch_user", { :controller => "users", :action => "update", :via => "post"})
  
  # Route for removing an account
  
  match("/cancel_user_account", { :controller => "users", :action => "destroy", :via => "get"})


  #------------------------------

  # ======= Add Your Routes Above These =============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
