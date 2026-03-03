# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

import launch
import launch.actions
import launch.substitutions
import launch_ros.actions

def generate_launch_description():
    region_publisher = launch_ros.actions.Node(
        package='mypkg',
        executable='region_publisher',
        )
    city_resolver = launch_ros.actions.Node(
        package='mypkg',
        executable='city_resolver',
        output='screen'
        )

    return launch.LaunchDescription([region_publisher, city_resolver])
