project('com.github.artemanufrij.translit', ['vala', 'c'],
        version: '1.0.0')

i18n = import('i18n')
gnome = import('gnome')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h'
]

deps = [
  dependency('granite'),
  dependency('gtk+-3.0'),
  dependency('gtkspell3-3.0'),
  meson.get_compiler('vala').find_library('posix')
]

executable(
    meson.project_name(),
    'src/Objects/KeyMapItem.vala',
    'src/Service/Translit.vala',
    'src/Settings.vala',
    'src/MainWindow.vala',
    'src/Application.vala',

 #   asresources,
    c_args: c_args,
    dependencies: [
        deps
    ],
    install : true
)

subdir('schemas')
subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')