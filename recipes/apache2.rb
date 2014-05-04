include_recipe 'apache2::mod_php5'

if node['php']['apache_conf_dir']
  template "#{node['php']['apache_conf_dir']}/php.ini" do
    source node['php']['ini']['template']
    cookbook node['php']['ini']['cookbook']
    unless platform?('windows')
      owner 'root'
      group 'root'
      mode '0644'
    end
    variables(:directives => node['php']['directives'])
    only_if { platform_family?('debian') && node['platform_version'].to_f >= 13.10 }
    notifies :restart, 'service[apache2]'
  end
end