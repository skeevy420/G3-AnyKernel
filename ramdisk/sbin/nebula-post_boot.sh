#!/system/bin/sh
#################################################################################
### Updated: 11/14/2015 : Added CPU Default 657 Since we now OC 700mhz        ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
###                                                                           ###
#################################################################################
BB=/sbin/bb/busybox

#################################################################
# Custom Kernel Settings for Nebula Kernel
# Based on Render Script by RenderBroken & 777Kernel
#
echo "-----------------------------------------------------------" | tee /dev/kmsg
echo "[NebulaKernel] Boot Script Started" | tee /dev/kmsg
stop mpdecision

############################
# MSM_Hotplug Settings
#
echo "-- Custom HotPlug Settings --" | tee /dev/kmsg
echo 1 > /sys/module/msm_hotplug/min_cpus_online
echo 2 > /sys/module/msm_hotplug/cpus_boosted
echo 500 > /sys/module/msm_hotplug/down_lock_duration
echo 2500 > /sys/module/msm_hotplug/boost_lock_duration
echo 200 5:100 50:50 350:200 > /sys/module/msm_hotplug/update_rates
echo 100 > /sys/module/msm_hotplug/fast_lane_load
echo 1 > /sys/module/msm_hotplug/max_cpus_online_susp

############################
# MSM Limiter
#
echo "-- Custom msm_limiter Settings --" | tee /dev/kmsg
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_0
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_1
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_2
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_3
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_0
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_1
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_2
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_3
echo 1728000 > /sys/kernel/msm_limiter/suspend_max_freq

###################################################################
### GPU CLK: Set default to 657 ###
echo "-- Custom GPU Max Clock Set --" | tee /dev/kmsg
#echo 657500000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk﻿
echo 657500000 > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/max_freq

############################
# MSM Thermal (Intelli-Thermal v2)
#
echo "-- Custom msm_thermal enabled --" | tee /dev/kmsg
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo 1 > /sys/module/msm_thermal/parameters/enabled

############################
# Alucard Touch Boost Settings
#
echo "-- Custom Alucard Touch Boost Settings --" | tee /dev/kmsg
echo 1497600 > /sys/module/alu_t_boost/parameters/input_boost_freq

############################
# Tweak Background Writeout
#
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 40 > /proc/sys/vm/dirty_ratio
echo 5 > /proc/sys/vm/dirty_background_ratio
echo 10 > /proc/sys/vm/swappiness

############################
# Power Effecient Workqueues (Enable for battery)
#
echo "-- Custom Power effecient Workgueues Enabled --" | tee /dev/kmsg
echo 1 > /sys/module/workqueue/parameters/power_efficient

############################
# Scheduler and Read Ahead
#
echo "-- Custom Scheduler and Read Ahead Settings --" | tee /dev/kmsg
echo zen > /sys/block/mmcblk0/queue/scheduler
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb

############################
# Governor Tunings
#
echo "-- Custom Governor Tunings --" | tee /dev/kmsg
echo interactive > /sys/kernel/msm_limiter/scaling_governor_0
echo 20000 1400000:40000 1700000:20000 > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo 1190400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
echo 85 1500000:90 1800000:70 > /sys/devices/system/cpu/cpufreq/interactive/target_loads
echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo 100000 > /sys/devices/system/cpu/cpufreq/interactive/max_freq_hysteresis
echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_slack

############################
# LMK Tweaks
#
echo "-- Custom LMK Tweaks --" | tee /dev/kmsg
echo 2560,4096,8192,16384,24576,32768 > /sys/module/lowmemorykiller/parameters/minfree
echo 32 > /sys/module/lowmemorykiller/parameters/cost

############################
# Synapse + UKM Support
#
uci reset
uci

echo "[NebulaKernel] Boot Script Completed!" | tee /dev/kmsg
echo "-----------------------------------------------------------" | tee /dev/kmsg
