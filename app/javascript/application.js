// Entry point for the build script in your package.json

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "./channels"

Rails.start()
ActiveStorage.start()
