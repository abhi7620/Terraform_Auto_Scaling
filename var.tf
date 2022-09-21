# Creating the autoscaling launch configuration Variables

variable "aws_autoscale_conf_img_id" {
  default = "ami-0729e439b6769d6ab"
}

variable "aws_autoscale_conf_intamce_type" {
  default = "t2.micro"
}

variable "aws_autoscale_conf_key_name" {
  default = "MasterKey"
}

# Creating the autoscaling Group configuration Variables

variable "autoscale_grp_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "autoscale_grp_max_size" {
  default = 2
}

variable "autoscale_grp_min_size" {
  default = 1
}

variable "autoscale_grp_health_check_period" {
  default = 30
}

variable "autoscale_grp_health_check_type" {
  default = "EC2"
}

variable "autoscale_grp_force_delete" {
  default = true
}

variable "autoscale_grp_termination_policies" {
  type    = list(string)
  default = ["OldestInstance"]
}

# autoscaling schedule of the autoscaling group varibales

variable "autoscale_schedule_min_size" {
  default = 1
}

variable "autoscale_schedule_max_size" {
  default = 2
}

variable "autoscale_schedule_desired_capacity" {
  default = 1
}

# autoscaling policy of the autoscaling group varibales

variable "aws_grp_policy_scaling_adjustment" {
  default = 2
}

variable "aws_grp_policy_scaling_adjustment_type" {
  default = "ChangeInCapacity"
}

variable "aws_grp_policy_scaling_cooldown" {
  default = 300
}

# AWS CLoudwatch Alarm that will autoscale the AWS EC2 instance based on CPU utilization variables.

variable "aws_cloudwatch_alarm_up_comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "aws_cloudwatch_alarm_up_evaluation_periods" {
  default = "2"
}

variable "aws_cloudwatch_alarm_up_metric_name" {
  default = "CPUUtilization"
}

variable "aws_cloudwatch_alarm_up_namespace" {
  default = "AWS/EC2"
}

variable "aws_cloudwatch_alarm_up_period" {
  default = "60"
}

variable "aws_cloudwatch_alarm_statistic" {
  default = "Average"
}

variable "aws_cloudwatch_alarm_up_threshold" {
  default = "10"
}

#variable "aws_cloudwatch_alarm_up_alarm_actions" {
#  type    = list(string)
#  default = ["${aws_autoscaling_policy.aws_grp_policy.arn}"]
#}


