
# Creating the autoscaling launch configuration that contains AWS EC2 instance details
resource "aws_launch_configuration" "aws_autoscale_conf" {
  name          = "web_config"
  image_id      = var.aws_autoscale_conf_img_id
  instance_type = var.aws_autoscale_conf_intamce_type
  key_name      = var.aws_autoscale_conf_key_name
}

# Creating the autoscaling group within us-east-1a availability zone
resource "aws_autoscaling_group" "aws_autoscale_grp" {
  name                      = "autoscalegroup"
  availability_zones        = var.autoscale_grp_zone
  max_size                  = var.autoscale_grp_max_size
  min_size                  = var.autoscale_grp_min_size
  health_check_grace_period = var.autoscale_grp_health_check_period
  health_check_type         = var.autoscale_grp_health_check_type
  force_delete              = var.autoscale_grp_force_delete
  termination_policies      = var.autoscale_grp_termination_policies
  launch_configuration      = aws_launch_configuration.aws_autoscale_conf.name
}

# Creating the autoscaling schedule of the autoscaling group
resource "aws_autoscaling_schedule" "aws_autoscale_schedule" {
  scheduled_action_name  = "autoscalegroup_action"
  min_size               = var.autoscale_schedule_min_size
  max_size               = var.autoscale_schedule_max_size
  desired_capacity       = var.autoscale_schedule_desired_capacity
  autoscaling_group_name = aws_autoscaling_group.aws_autoscale_grp.name
  start_time             = "2022-09-09T18:00:00Z"
}

# Creating the autoscaling policy of the autoscaling group
resource "aws_autoscaling_policy" "aws_grp_policy" {
  name                   = "autoscalegroup_policy"
  scaling_adjustment     = var.aws_grp_policy_scaling_adjustment
  adjustment_type        = var.aws_grp_policy_scaling_adjustment_type
  cooldown               = var.aws_grp_policy_scaling_cooldown
  autoscaling_group_name = aws_autoscaling_group.aws_autoscale_grp.name
}

# Creating the AWS CLoudwatch Alarm that will autoscale the AWS EC2 instance based on CPU utilization.
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_alarm_up" {
  alarm_name          = "aws_cloudwatch_alarm_up"
  comparison_operator = var.aws_cloudwatch_alarm_up_comparison_operator
  evaluation_periods  = var.aws_cloudwatch_alarm_up_evaluation_periods
  metric_name         = var.aws_cloudwatch_alarm_up_metric_name
  namespace           = var.aws_cloudwatch_alarm_up_namespace
  period              = var.aws_cloudwatch_alarm_up_period
  statistic           = var.aws_cloudwatch_alarm_statistic
  threshold           = var.aws_cloudwatch_alarm_up_threshold
  alarm_actions       = ["${aws_autoscaling_policy.aws_grp_policy.arn}"]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.aws_autoscale_grp.name}"
  }
}

