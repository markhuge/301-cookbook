service "redirector" do
  provider Chef::Provider::Service::Upstart
  action [:stop]
end

template "/etc/init/redirector.conf" do
  source "upstart.erb"
  owner "root"
  group "root"
  mode "0600"
  variables({
    :user => username,
    :group => groupname,
    :path => "#{deploy_path}/current",
    :proto => node['redirect']['protocol'],
    :domain => node['redirect']['domain']
  })
end

service "redirector" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  subscribes :reload, "template[/etc/init/redirector.conf]", :immediately
end
