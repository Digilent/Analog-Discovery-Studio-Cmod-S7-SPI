Analog Discovery Studio + Cmod S7 SPI Demo
==============

Description
--------------
This project is a Vivado design for the Cmod S7-25, used as a component of a larger demo, found on the [Digilent Wiki](https://reference.digilentinc.com/reference/instrumentation/analog-discovery-studio/cmod-s7-demo). The Cmod S7-25's analog input pins are used to capture a voltage output by the Analog Discovery Studio's Wavegen pins. The top 8 bits of the digital representation of this voltage is output on the Cmod S7-25's Pmod Port, to be converted back into analog by a Pmod R2R, connected to the Analog Discovery Studio's Oscilloscope channel 1 pin. In addition, eight of the Cmod S7-25's digital I/O pins are used as a SPI bus, as well as to control the SPI master module in the Cmod S7-25 design.

Requirements
--------------
* **Cmod S7-25**: To purchase a Cmod S7-25, see the [Digilent Store](https://store.digilentinc.com/cmod-s7-breadboardable-spartan-7-fpga-module/)
* **Vivado 2019.1 Installation**: To set up Vivado, see the [Installing Vivado and Digilent Board Files Tutorial](https://reference.digilentinc.com/vivado/installing-vivado/start).
* **MicroUSB Cable**: For use in programming the Cmod S7-25
* Other components as required by the full demo system, documented on the [Digilent Wiki](https://reference.digilentinc.com/reference/instrumentation/analog-discovery-studio/cmod-s7-demo)
 
Demo Setup
--------------
1. Download and extract the most recent release ZIP archive from this repository's [Releases Page](https://github.com/Digilent/Analog-Discovery-Studio-Cmod-S7-SPI/releases).
2. Open the project in Vivado 2019.1 by double clicking on the included XPR file found at "\<archive extracted location\>/vivado_proj/Basys-3-GPIO.xpr".
3. In the Flow Navigator panel on the left side of the Vivado window, click **Open Hardware Manager**.
4. Plug the Cmod S7-25 into the computer using a MicroUSB cable.
6. In the green bar at the top of the Vivado window, click **Open target**. Select **Auto connect** from the drop down menu.
7. In the green bar at the top of the Vivado window, click **Program device**.
8. In the Program Device Wizard, enter "\<archive extracted location\>vivado_proj/Basys-3-GPIO.runs/impl_1/top.bit" into the "Bitstream file" field. Then click **Program**.
9. The demo will now be programmed onto the Cmod S7-25. See the Description section of this README to learn how to interact with this demo.

Next Steps
--------------
This demo can be used as a basis for other projects, either by adding sources included in the demo's release to those projects, or by modifying the sources in the release project.

Check out the Cmod S7's [Resource Center](https://reference.digilentinc.com/reference/programmable-logic/cmod-s7/start) and the Analog Discovery Studio's [Resource Center](https://reference.digilentinc.com/reference/instrumentation/analog-discovery-studio/start) to find more documentation, demos, and tutorials.

For technical support or questions, please post on the [Digilent Forum](https://forum.digilentinc.com).

Additional Notes
--------------
For more information on how this project is version controlled, refer to the [Digilent Vivado Scripts Repository](https://github.com/digilent/digilent-vivado-scripts)