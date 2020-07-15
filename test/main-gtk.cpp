#include "hello-world-gtk.h"
#include <gtkmm/main.h>

// compile with: g++ -o hello-world-gtkmm3.exe hello-world-gtk.cpp main-gtk.cpp $(pkg-config --cflags --libs gtkmm-3.0 gtksourceview-4 json-glib-1.0 libpeas-1.0 libsoup-2.4 libxml++-3.0)

int main (int argc, char *argv[])
{
  Gtk::Main kit(argc, argv);

  HelloWorld helloworld;
  //Shows the window and returns when it is closed.
  Gtk::Main::run(helloworld);

  return 0;
}
