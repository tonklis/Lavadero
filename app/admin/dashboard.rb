ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    div class: "blank_slate_container", id: "dashboard_default_message" do
    
      script do
        "function updateBookings() {
          $.ajax({
                url: '/checkfront_data/update_bookings',
		type: 'GET',
		dataType: 'html',
                beforeSend: function(jqXHR, settings){
                  $.loader();
                },
		error: function(jqXHR, textStatus, errorThrown){
		  alert('Error. Intenta de nuevo.')
                },
		success: function(data, textStatus, jqXHR){
                },
                complete: function(jqXHR, textStatus){
                  $.loader('close');
                }
          })
        }".html_safe
      end
      span class: "blank_slate" do
        "<button type='button' id='updateButton' onclick='updateBookings()'>Actualiza Ordenes</button>".html_safe
      end
    end

  end

end
