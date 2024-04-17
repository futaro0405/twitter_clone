// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PreviewsController from "./previews_controller"
application.register("previews", PreviewsController)

import TabController from "./tab_controller"
application.register("tab", TabController)
