#!/system/bin/sh

BB=/sbin/bb/busybox

############################
# Custom Kernel Settings for NebulaKernel
#
echo "[Nebula Kernel] Performance Boot Service Started" | tee /dev/kmsg
stop mpdecision

############################
# MSM_Hotplug Settings
#
echo 4 > /sys/module/msm_hotplug/min_cpus_online
echo 4 > /sys/module/msm_hotplug/cpus_boosted
echo 500 > /sys/module/msm_hotplug/down_lock_duration
echo 2500 > /sys/module/msm_hotplug/boost_lock_duration
echo 200 5:100 50:50 350:200 > /sys/module/msm_hotplug/update_rates
echo 100 > /sys/module/msm_hotplug/fast_lane_load
echo 1 > /sys/module/msm_hotplug/max_cpus_online_susp

############################
# MSM Limiter
#
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_0
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_1
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_2
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_3
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_0
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_1
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_2
echo 2457600 > /sys/kernel/msm_limiter/resume_max_freq_3
echo 1728000 > /sys/kernel/msm_limiter/suspend_max_freq

############################
# MSM Thermal (Intelli-Thermal v2)
#
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo 1 > /sys/module/msm_thermal/parameters/enabled

############################
# CPU-Boost Settings
#
# Needs updating to Alucard

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
echo 1 > /sys/module/workqueue/parameters/power_efficient

############################
# Scheduler and Read Ahead
#
echo sio > /sys/block/mmcblk0/queue/scheduler
echo 2048 > /sys/block/mmcblk0/bdi/read_ahead_kb

############################
# Governor Tunings
#
echo performance > /sys/kernel/msm_limiter/scaling_governor_0
echo performance > /sys/kernel/msm_limiter/scaling_governor_1
echo performance > /sys/kernel/msm_limiter/scaling_governor_2
echo performance > /sys/kernel/msm_limiter/scaling_governor_3


############################
# LMK Tweaks
#
echo 2560,4096,8192,16384,24576,32768 > /sys/module/lowmemorykiller/parameters/minfree
echo 32 > /sys/module/lowmemorykiller/parameters/cost

echo "[Nebula Kernel] Performance Boot Service Completed!" | tee /dev/kmsg
