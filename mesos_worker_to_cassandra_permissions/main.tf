resource "aws_security_group_rule" "cql" {
  security_group_id = "${var.cassandra_client_security_group_id}"

  type      = "ingress"
  from_port = 9042
  to_port   = 9042
  protocol  = "tcp"
  source_security_group_id = "${var.mesos_worker_security_group_id}"
}

resource "aws_security_group_rule" "thrift" {
  security_group_id = "${var.cassandra_client_security_group_id}"

  type      = "ingress"
  from_port = 9160
  to_port   = 9160
  protocol  = "tcp"
  source_security_group_id = "${var.mesos_worker_security_group_id}"
}