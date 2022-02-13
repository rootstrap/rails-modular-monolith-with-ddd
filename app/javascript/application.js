// Entry point for the build script in your package.json

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import * as bootstrap from "bootstrap"
import "./channels"

Rails.start()
ActiveStorage.start()
