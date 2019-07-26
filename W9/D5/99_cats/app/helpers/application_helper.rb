module ApplicationHelper
    def auth_token
        html_string = "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">"
        html_string.html_safe
    end
    
end
