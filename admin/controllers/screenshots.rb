App::Admin.controllers :screenshots do
  get :index do
    @title = "Screenshots"
    @screenshots = Screenshot.all
    render 'screenshots/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'screenshot')
    @screenshot = Screenshot.new
    render 'screenshots/new'
  end

  post :create do
    @screenshot = Screenshot.new(params[:screenshot])
    if @screenshot.save
      @title = pat(:create_title, :model => "screenshot #{@screenshot.id}")
      flash[:success] = pat(:create_success, :model => 'Screenshot')
      params[:save_and_continue] ? redirect(url(:screenshots, :index)) : redirect(url(:screenshots, :edit, :id => @screenshot.id))
    else
      @title = pat(:create_title, :model => 'screenshot')
      flash.now[:error] = pat(:create_error, :model => 'screenshot')
      render 'screenshots/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "screenshot #{params[:id]}")
    @screenshot = Screenshot.get(params[:id])
    if @screenshot
      render 'screenshots/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'screenshot', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "screenshot #{params[:id]}")
    @screenshot = Screenshot.get(params[:id])
    if @screenshot
      if @screenshot.update(params[:screenshot])
        flash[:success] = pat(:update_success, :model => 'Screenshot', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:screenshots, :index)) :
          redirect(url(:screenshots, :edit, :id => @screenshot.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'screenshot')
        render 'screenshots/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'screenshot', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Screenshots"
    screenshot = Screenshot.get(params[:id])
    if screenshot
      if screenshot.destroy
        flash[:success] = pat(:delete_success, :model => 'Screenshot', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'screenshot')
      end
      redirect url(:screenshots, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'screenshot', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Screenshots"
    unless params[:screenshot_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'screenshot')
      redirect(url(:screenshots, :index))
    end
    ids = params[:screenshot_ids].split(',').map(&:strip)
    screenshots = Screenshot.all(:id => ids)
    
    if screenshots.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Screenshots', :ids => "#{ids.to_sentence}")
    end
    redirect url(:screenshots, :index)
  end
end
