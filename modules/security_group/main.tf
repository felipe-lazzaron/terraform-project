resource "aws_security_group" "lb_sg" {
  name        = "lb_sg_example"                    // Nome do grupo de segurança
  description = "Allow inbound traffic on port 80" // Descrição do grupo de segurança
  vpc_id      = var.vpc_id                         // Certifique-se de que esteja associado à mesma VPC

  ingress {
    from_port   = 80            // Porta de origem
    to_port     = 80            // Porta de destino
    protocol    = "tcp"         // Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] // Libera tráfego de qualquer origem
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg_example"                     // Nome do grupo de segurança
  description = "Allow inbound traffic on port 3306" // Descrição do grupo de segurança
  vpc_id      = var.vpc_id                           // Certifique-se de que esteja associado à mesma VPC

  ingress {
    from_port   = 3306          // Porta de origem
    to_port     = 3306          // Porta de destino
    protocol    = "tcp"         // Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] // Libera tráfego de qualquer origem
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg_example"                   // Nome do grupo de segurança
  description = "Allow inbound traffic on port 22" // Descrição do grupo de segurança
  vpc_id      = var.vpc_id                         // Certifique-se de que esteja associado à mesma VPC

  ingress {
    from_port   = 22            // Porta de origem
    to_port     = 22            // Porta de destino
    protocol    = "tcp"         // Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] // Libera tráfego de qualquer origem
  }
}


