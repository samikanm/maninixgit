variable "instance_type" {
  default = {
    production = "c4.large"
    staging    = "t2.micro"
  }
}

resource "aws_instance" "api" {
  ami                     = "ami-1df9ce0b"
  instance_type           = "t2.micro"
  disable_api_termination = "true"
  key_name                = "fr-admin"

  vpc_security_group_ids = [
    "${var.management}",
    "${aws_security_group.sg.id}",
  ]

  subnet_id            = "${element(var.private, 1)}"
  iam_instance_profile = "${aws_iam_instance_profile.role.name}"

  tags {
    # Name format: domain%02d-az-region-role-service-brand
    # e.g. stg01-a-tky-web-account-uq
    # note. if it is template server, you should not include az like
    # stg01-tky-web-account-uq
    Name = "${var.name["ec2_api"]}"

    Service = "${var.tags["service"]}"
    Brand   = "${var.tags["brand"]}"
    Domain  = "${var.tags["domain"]}"
    Env     = "${var.tags["env"]}"
    Country = "${var.tags["country"]}"
    Segment = "private"
    Role    = "web"
    Roles   = "base, gl-account-core-api"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }

  lifecycle {
    ignore_changes = ["ami"]
  }
}

resource "aws_instance" "batch" {
  ami                     = "ami-1df9ce0b"
  instance_type           = "t2.micro"
  disable_api_termination = "true"
  key_name                = "fr-admin"

  vpc_security_group_ids = [
    "${var.management}",
    "${aws_security_group.sg.id}",
  ]

  subnet_id            = "${element(var.private, 1)}"
  iam_instance_profile = "${aws_iam_instance_profile.role.name}"

  tags {
    # Name format: domain%02d-az-region-role-service-brand
    # e.g. stg01-a-tky-web-account-uq
    # note. if it is template server, you should not include az like
    # stg01-tky-web-account-uq
    Name = "${var.name["ec2_batch"]}"

    Service = "${var.tags["service"]}"
    Brand   = "${var.tags["brand"]}"
    Domain  = "${var.tags["domain"]}"
    Env     = "${var.tags["env"]}"
    Country = "${var.tags["country"]}"
    Segment = "private"
    Role    = "web"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
  }

  lifecycle {
    ignore_changes = ["ami"]
  }
}

resource "aws_instance" "spa" {
  ami                     = "ami-ade4a9bb"
  instance_type           = "t2.medium"
  disable_api_termination = "true"
  key_name                = "fr-admin"

  vpc_security_group_ids = [
    "${var.management}",
    "${aws_security_group.sg.id}",
  ]

  subnet_id            = "${element(var.private, 1)}"
  iam_instance_profile = "${aws_iam_instance_profile.role.name}"

  tags {
    # Name format: domain%02d-az-region-role-service-brand
    # e.g. stg01-a-tky-web-account-uq
    # note. if it is template server, you should not include az like
    # stg01-tky-web-account-uq
    Name = "${var.name["ec2_spa"]}"

    Service = "${var.tags["service"]}"
    Brand   = "${var.tags["brand"]}"
    Domain  = "${var.tags["domain"]}"
    Env     = "${var.tags["env"]}"
    Country = "${var.tags["country"]}"
    Segment = "private"
    Role    = "web"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
  }

  lifecycle {
    ignore_changes = ["ami"]
  }
}
