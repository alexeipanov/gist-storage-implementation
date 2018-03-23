class FragmentsController < ApplicationController
  caches_page :index, :show
  before_action :set_fragment, only: [:show]
  after_action :cache_update, only: [:create]

  require 'digest'

  def index
    @fragments = Fragment.recent(20)
    @total_count = Fragment.total_count
  end

  def show
  end

  def new
    @fragment = Fragment.new
  end

  def create
    @fragment = Fragment.new(fragment_params.merge({ :url => Digest::SHA1.hexdigest(fragment_params[:value])[0..8] }))

    respond_to do |format|
      if @fragment.save
        format.html { redirect_to @fragment, notice: 'Fragment was successfully created.' }
        format.json { render :show, status: :created, location: @fragment }
      else
        format.html { render :new }
        format.json { render json: @fragment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_fragment
      /^\d+$/.match(params[:id]) ? find_by_id : find_by_url
    end

    def find_by_id
      @fragment = Fragment.find(params[:id])
    end

    def find_by_url
      @fragment = Fragment.find_by(url: params[:id])
    end

    def fragment_params
      params.require(:fragment).permit(:value, :private)
    end

    def cache_update
      Rails.cache.write('fragments/total_count', Fragment.count, expires_in: 12.hours)
    end

end
