groupname   = node['redirect']['group']
deploy_path = node['redirect']['deploy_path']
artifact    = "redirector-#{node['redirect']['version']}.tar.gz"
version     = node['redirector']['version']

user username do
  shell "/bin/false"
  home  deploy_path
  system true
  action :create
end

group groupname do
  action :modify
  members username
  append true
end

asset = github_asset artifact do
  repo "markhuge/redirector"
  release version
  action :download
end

libarchive_file artifact do
  path asset.asset_path
  extract_to "#{deploy_path}/#{version}"
  owner username
  group groupname
  action :extract
  only_if { ::File.exist?(asset.asset_path) }
end

link "#{deploy_path}/current" do
  to deploy_path
end

