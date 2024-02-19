// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require jquery3
//= require popper
//= require bootstrap

import "@hotwired/turbo-rails"
import "controllers"

//= require jquery
//= require jquery.raty
//= require ratyrate

import jquery from "jquery"
window.$ = jquery
