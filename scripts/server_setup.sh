# this script executes initial setup commands
# (installing git, vim, cloning this repo, etc)
# on an archlinux instance so that bootstrap.sh can be run

essential_programs="glibc vim git"
other_programs="jq rsync htop man cronie docker python-pip ipython which"
hosts="newgoog newgoog2 newserver"

for host in $hosts; do
	# echo -- Setting up mirrorlist on $host
	# ssh $host 'echo -e "## United States\nServer = https://mirrors.mit.edu/archlinux/\$repo/os/\$arch" | sudo tee /etc/pacman.d/mirrorlist'
	# echo -- Installing archlinux-keyring on $host
	# ssh $host sudo pacman --noconfirm -Sy archlinux-keyring
	# echo -- Installing $(echo $essential_programs $other_programs | sed 's/ /, /g') on $host
	# ssh $host sudo pacman --noconfirm -Sy $essential_programs $other_programs
	# echo -- Cloning linuxfiles on $host
	# ssh $host git clone https://github.com/bschlaman/linuxfiles.git
	echo -- Generating ssh keypair on $host
	ssh $host '< /dev/zero ssh-keygen -q -N ""'
done
for host in $hosts; do
	ssh $host cat ~/.ssh/id_rsa.pub
done

# useful arch compute instance creation commands for arch
# git clone https://github.com/GoogleCloudPlatform/compute-archlinux-image-builder
# sed -i 's/10G/30G/' build-arch-gce
# gcloud compute instances create archlinux --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB
# gcloud compute instances create archsite --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB
# gcloud compute instances create server --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB
