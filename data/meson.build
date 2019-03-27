icon_sizes = ['32', '48', '64']

foreach i : icon_sizes
  install_data(
    join_paths('icons', i, meson.project_name() + '.svg'),
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
  )
  install_data(
    join_paths('icons', i, meson.project_name() + '.svg'),
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
  )
endforeach

i18n.merge_file(
    input: meson.project_name() + '.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

i18n.merge_file(
    input: meson.project_name() + '.appdata.xml.in',
    output: meson.project_name() + '.appdata.xml',
    po_dir: join_paths(meson.source_root(), 'po'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)
prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))
pkgdatadir = join_paths(datadir, meson.project_name())

install_data(
  join_paths ('dictionary', 'ru_RU'),
  install_dir: join_paths (pkgdatadir, 'dictionary')
)

install_data(
  join_paths ('dictionary', 'ua_UA'),
  install_dir: join_paths (pkgdatadir, 'dictionary')
)

install_data(
  join_paths ('dictionary', 'be_BY'),
  install_dir: join_paths (pkgdatadir, 'dictionary')
)