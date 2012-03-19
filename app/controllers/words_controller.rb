require 'time'

class WordsController < ApplicationController
   # GET /words
   # GET /words.json
   def index
      @word = Word.new
      @word.month = distance_of_time_in_months(Date.parse("24.02.2010"), Time.now)
      
      tri_state_from_session(:german)
      tri_state_from_session(:polish)
      x = params[:german] ? Word.where("german = ?", params[:german] == "true") : Word
      y = params[:polish] ? x.where("polish = ?", params[:polish] == "true") : x
      @words = y.order('word').paginate(:page => params[:page])

      respond_to do |format|
         format.html # index.html.erb
         format.json { render json: @words }
         format.js # renders index.js.erb
      end
   end

   # GET /words/1
   # GET /words/1.json
   def show
      @word = Word.find(params[:id])

      respond_to do |format|
         format.html # show.html.erb
         format.json { render json: @word }
      end
   end

   # GET /words/new
   # GET /words/new.json
   def new
      @word = Word.new

      respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @word }
      end
   end

   # GET /words/1/edit
   def edit
      @word = Word.find(params[:id])
   end

   # POST /words
   # POST /words.json
   def create
      @word = Word.new(params[:word])

      respond_to do |format|
         if @word.save
            format.html { redirect_to Word, notice: 'Wort erfolgreich angelegt.' }
            format.json { render json: @word, status: :created, location: @word }
         else
            format.html { render action: "new" }
            format.json { render json: @word.errors, status: :unprocessable_entity }
         end
      end
   end

   # PUT /words/1
   # PUT /words/1.json
   def update
      @word = Word.find(params[:id])

      respond_to do |format|
         if @word.update_attributes(params[:word])
            format.html { redirect_to Word, notice: 'Wort wurde erfolgreich geaendert.' }
            format.json { head :no_content }
         else
            format.html { render action: "edit" }
            format.json { render json: @word.errors, status: :unprocessable_entity }
         end
      end
   end

   # DELETE /words/1
   # DELETE /words/1.json
   def destroy
      @word = Word.find(params[:id])
      @word.destroy

      respond_to do |format|
         format.html { redirect_to words_url, notice: 'Wort wurde erfolgreich geloescht.' }
         format.json { head :no_content }
      end
   end

   private

   def tri_state_from_session param
      params[param] = session[param] if session[param] and not params[param]
      params[param] = nil if params[param] == 'none'
      session[param] = params[param]
   end

   def distance_of_time_in_months from_time, to_time
      years = to_time.year - from_time.year
      months = to_time.month - from_time.month
      days = to_time.day - from_time.day
      return years * 12 + months + (days < 0 ? -1 : 0)
   end
end
