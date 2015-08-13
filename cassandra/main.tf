resource "aws_security_group" "cassandra" {
  name = "foo"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 7001
    to_port = 7001
    protocol = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "thrift" {
  security_group_id        = "${aws_security_group.cassandra_internal.id}"

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "9160"
  to_port                  = "9160"
  source_security_group_id = "${aws_security_group.opscenter.id}"
}

resource "aws_security_group_rule" "opscenter_agent" {
  security_group_id        = "${aws_security_group.cassandra_internal.id}"

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "61621"
  to_port                  = "61621"
  source_security_group_id = "${aws_security_group.opscenter.id}"
}

resource "aws_security_group" "cassandra_internal" {
  name = "cassandra_internal"
  description = "Expose ports for opscenter and client communication."
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "opscenter" {
  name = "opscenter"
  description = "OpsCenter"
  vpc_id = "${var.vpc_id}"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}