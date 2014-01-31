class PaperclipinsController < ApplicationController
  # GET /paperclipins
  # GET /paperclipins.json
  def index
    @paperclipins = Paperclipin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @paperclipins }
    end
  end

  # GET /paperclipins/1
  # GET /paperclipins/1.json
  def show
    @paperclipin = Paperclipin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @paperclipin }
    end
  end

  # GET /paperclipins/new
  # GET /paperclipins/new.json
  def new
    @paperclipin = Paperclipin.new
  end

  # GET /paperclipins/1/edit
  def edit
    @paperclipin = Paperclipin.find(params[:id])
  end

  # POST /paperclipins
  # POST /paperclipins.json
  def create
    @paperclipin = Paperclipin.new(params[:paperclipin])

    respond_to do |format|
      if @paperclipin.save
        format.html { redirect_to @paperclipin, :notice => 'Paperclipin was successfully created.' }
        format.json { render :json => @paperclipin, :status => :created, :location => @paperclipin }
      else
        format.html { render :action => "new" }
        format.json { render :json => @paperclipin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /paperclipins/1
  # PUT /paperclipins/1.json
  def update
    @paperclipin = Paperclipin.find(params[:id])

    respond_to do |format|
      if @paperclipin.update_attributes(params[:paperclipin])
        format.html { redirect_to @paperclipin, :notice => 'Paperclipin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @paperclipin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paperclipins/1
  # DELETE /paperclipins/1.json
  def destroy
    @paperclipin = Paperclipin.find(params[:id])
    @paperclipin.destroy

    respond_to do |format|
      format.html { redirect_to paperclipins_url }
      format.json { head :no_content }
    end
  end
end
