class PagesController < ApplicationController
    def main
        @reviews = Review.recent
    end
end
