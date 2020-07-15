#include "hello-world-gtk.h"
#include <iostream>
#include <vector>
#include <gtksourceview/gtksource.h>
#include <json-glib/json-glib.h>
#include <libpeas/peas.h>
#include <libsoup/soup.h>
#include <libxml++/libxml++.h>


HelloWorld::HelloWorld()
: m_button("Hello World")   // creates a new button with label "Hello World".
{

  GType json_node_type = json_node_get_type();
  GType peas_type = peas_extension_get_type();
  GType soup_type = soup_message_get_type();

  xmlpp::Document doc;

  GtkSourceLanguageManager *language_manager = gtk_source_language_manager_get_default();
  const gchar * const *ids = gtk_source_language_manager_get_language_ids(language_manager);
  std::cout << "number of languages found: " << g_strv_length((gchar **) ids) << std::endl;


  // Sets the border width of the window.
  set_border_width(10);

  // When the button receives the "clicked" signal, it will call the
  // on_button_clicked() method defined below.
  m_button.signal_clicked().connect(sigc::mem_fun(*this,
              &HelloWorld::on_button_clicked));

  // This packs the button into the Window (a container).
  add(m_button);

  // The final step is to display this newly created widget...
  m_button.show();
}

HelloWorld::~HelloWorld()
{
}

void HelloWorld::on_button_clicked()
{
  std::cout << "Hello World" << std::endl;
}
