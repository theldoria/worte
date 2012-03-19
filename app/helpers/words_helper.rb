module WordsHelper
   # nil->"true"->"false"->"none"->"true"...
   def tri_state_href param
      return params[param] ? params[param] == "true" ?  words_path(param => 'false') :  words_path(param => 'none') :  words_path(param => 'true')
   end

   def tri_state_class param
      return params[param] ? params[param] == "true" ?  "toggle_true" :  "toggle_false" :  "toggle_none"
   end
end
