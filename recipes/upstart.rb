username  = node['301']['user']
groupname = node['301']['group']
svc       = node['301']['service_name']

user username do
 shell "/bin/false"
  system true
  action :create
end

group groupname do
  action :modify
  members username
  append true
end


service svc do
  provider Chef::Provider::Service::Upstart
  action [:stop]
end

template "/etc/init/#{svc}.conf" do
  source "upstart.erb"
  owner "root"
  group "root"
  mode "0600"
  variables({
    :svc    => svc,
    :user   => username,
    :group  => groupname,
    :port   => node['301']['port'],
    :proto  => node['301']['protocol'],
    :domain => node['301']['domain']
  })
end

service svc do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  subscribes :reload, "template[/etc/init/#{svc}.conf]", :immediately
end
