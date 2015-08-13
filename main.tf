resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/19"
	tags {
		Name = "tf-sg-test"
	}
}

module "cassandra" {
  source = "./cassandra"
  vpc_id = "${aws_vpc.default.id}"
}

module "mesos" {
  source = "./mesos"
  vpc_id = "${aws_vpc.default.id}"
}

module "mesos_worker_to_cassandra_permissions" {
  source = "./mesos_worker_to_cassandra_permissions"
  cassandra_client_security_group_id = "${module.cassandra.cassandra_client_security_group_id}"
  mesos_worker_security_group_id      = "${module.mesos.mesos_worker_security_group_id}"
}