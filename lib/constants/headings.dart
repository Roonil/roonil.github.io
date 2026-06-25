import 'package:flutter/widgets.dart';
import 'package:wayves_wiki/screens/advanced/cli_args_screen.dart';
import 'package:wayves_wiki/screens/advanced/piping_screen.dart';
import 'package:wayves_wiki/screens/getting_started/installation_screen.dart';
import 'package:wayves_wiki/screens/introduction/glsl_functions_screen.dart';
import 'package:wayves_wiki/screens/recommendations/performance_screen.dart';
import 'package:wayves_wiki/screens/getting_started/usage_screen.dart';
import 'package:wayves_wiki/screens/introduction/data_types_screen.dart';
import 'package:wayves_wiki/screens/introduction/overview_screen.dart';
import 'package:wayves_wiki/screens/main_configuration/main_config_overview_screen.dart';
import 'package:wayves_wiki/screens/main_configuration/styling_screen.dart';
import 'package:wayves_wiki/screens/recommendations/tips_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/colors_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/creating_your_own_shaders_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/extras_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/post_processing_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/special_directives_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/z_orders_screen.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_configuration_screen.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_examples_screen.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_life_cycle_screen.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_overview_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_config_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_examples_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_overview_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_configuration_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_examples_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_life_cycle_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_screen.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_config_screen.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_examples_screen.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_overview_screen.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_screen.dart';
import 'package:wayves_wiki/screens/shaders/shaders_overview_screen.dart';

Map<String, Map<String, GlobalKey>> headings = {
  OverviewScreen.routeName: {
    "Shaders": GlobalKey(),
    "Vertex Shader": GlobalKey(),
    "Fragment Shader": GlobalKey(),
    "High-Level Overview of a Shader Pipeline": GlobalKey(),
  },
  InstallationScreen.routeName: {
    "Requirements": GlobalKey(),
    "Installation": GlobalKey(),
  },

  GlslFunctionsScreen.routeName: {"GLSL Functions": GlobalKey()},
  UsageScreen.routeName: {
    "Usage": GlobalKey(),
    "Starter Configuration": GlobalKey(),
  },
  PerformanceScreen.routeName: {
    "Performance": GlobalKey(),
    "New GTK GL Renderer": GlobalKey(),
    "Using the Old GTK Renderer": GlobalKey(),
  },

  ShadersOverviewScreen.routeName: {"Overview": GlobalKey()},

  TipsScreen.routeName: {
    "Tips": GlobalKey(),
    "Audio Configuration": GlobalKey(),
    "Configuration Overrides": GlobalKey(),
    "Shader Specification Structure": GlobalKey(),
    "Making Conditions Branchless": GlobalKey(),
  },

  StylingScreen.routeName: {"Styling": GlobalKey(), "Examples": GlobalKey()},

  ChainConfigurationScreen.routeName: {
    "Trivial Working Structure": GlobalKey(),
  },

  ChainExamplesScreen.routeName: {"Dynamically-colored Chain": GlobalKey()},

  DataTypesScreen.routeName: {
    "Data Types": GlobalKey(),
    "Scalars": GlobalKey(),
    "Vectors": GlobalKey(),
    "Matrices": GlobalKey(),
    "Explicit Type Conversion": GlobalKey(),
  },

  YAMLSpecificationScreen.routeName: {
    "Configuration File": GlobalKey(),
    "PipeWire Settings": GlobalKey(),
    "Channels Map": GlobalKey(),
    "Smooth Settings": GlobalKey(),
    "Gravity Settings": GlobalKey(),
    "Audio Overrides": GlobalKey(),
    "Post-Processing Object": GlobalKey(),
    "Paintable Object": GlobalKey(),
    "Shader Object": GlobalKey(),
    "Audio Object": GlobalKey(),
  },
  ChainOverviewScreen.routeName: {
    "Chain": GlobalKey(),
    "Audio Settings": GlobalKey(),
    "Audio": GlobalKey(),
    "Chain ": GlobalKey(),
  },
  ChainLifeCycleScreen.routeName: {
    "Life Cycle": GlobalKey(),
    "init()": GlobalKey(),
    "audioFetch()": GlobalKey(),
    "setProps()": GlobalKey(),
  },
  LinearOverviewScreen.routeName: {
    "Linear": GlobalKey(),
    "Primitives": GlobalKey(),
    "Fragments": GlobalKey(),
    "Working": GlobalKey(),
    "Audio Settings": GlobalKey(),
    "Audio": GlobalKey(),
    "Fragment": GlobalKey(),
    "Cap": GlobalKey(),
    "Connector Half": GlobalKey(),
    "Connector": GlobalKey(),
    "Bar": GlobalKey(),
    "Particle": GlobalKey(),
  },
  LinearConfigScreen.routeName: {"Trivial Working Structure": GlobalKey()},

  LinearScreen.routeName: {
    "Life Cycle": GlobalKey(),
    "init()": GlobalKey(),
    "audioFetch()": GlobalKey(),
    "setOffsets()": GlobalKey(),
    "setProps()": GlobalKey(),
    "setParticleDownProps()": GlobalKey(),
    "modifySDFs()": GlobalKey(),
  },
  LinearExamplesScreen.routeName: {
    "Classic Bars": GlobalKey(),
    "Particles": GlobalKey(),
    "Merged Bars": GlobalKey(),
  },

  AngularOverviewScreen.routeName: {
    "Angular": GlobalKey(),
    "Audio Settings": GlobalKey(),
    "Audio": GlobalKey(),
    "Fragment": GlobalKey(),
    "Circle": GlobalKey(),
    "Cap": GlobalKey(),
    "Connector Half": GlobalKey(),
    "Connector": GlobalKey(),
    "Bar": GlobalKey(),
    "Particle": GlobalKey(),
  },
  AngularConfigScreen.routeName: {"Trivial Working Structure": GlobalKey()},
  AngularScreen.routeName: {
    "Life Cycle": GlobalKey(),
    "init()": GlobalKey(),
    "audioFetch()": GlobalKey(),
    "setOffsets()": GlobalKey(),
    "setProps()": GlobalKey(),
    "setParticleDownProps()": GlobalKey(),
    "modifySDFs()": GlobalKey(),
  },

  AngularExamplesScreen.routeName: {
    "Classic Bars": GlobalKey(),
    "Particles": GlobalKey(),
  },
  NcsScreen.routeName: {
    "NCS": GlobalKey(),
    "Base Form": GlobalKey(),
    "Particle Properties": GlobalKey(),
    "Audio Controls": GlobalKey(),
    "Fractal Field Controls": GlobalKey(),
    "Sphere Controls": GlobalKey(),
  },

  NcsConfigurationScreen.routeName: {"Trivial Working Structure": GlobalKey()},

  NcsExamplesScreen.routeName: {"Standard NCS Visualiser": GlobalKey()},
  NcsLifeCycleScreen.routeName: {
    "Life Cycle": GlobalKey(),
    "init()": GlobalKey(),
    "setProps()": GlobalKey(),
    "modifyNoiseCoordinates()": GlobalKey(),
    "setPropsWithNoise()": GlobalKey(),
    "modifySphericalDisplacement()": GlobalKey(),
  },

  PostProcessingScreen.routeName: {
    "Post-Processing": GlobalKey(),
    "Glow": GlobalKey(),
    "Rotate": GlobalKey(),
    "Examples": GlobalKey(),
  },

  ColorsScreen.routeName: {
    "Colors": GlobalKey(),
    "rgb()": GlobalKey(),
    "rgba()": GlobalKey(),
    "hsv()": GlobalKey(),
    "hsva()": GlobalKey(),
    "interpolateHue(vec3)": GlobalKey(),
    "interpolateHue(vec4)": GlobalKey(),
  },

  ExtrasScreen.routeName: {
    "Noise Functions": GlobalKey(),
    "Coordinate System Rotation": GlobalKey(),
  },

  ZOrdersScreen.routeName: {
    "Z-Index Ordering": GlobalKey(),
    "Circle Group": GlobalKey(),
    "Bars Group": GlobalKey(),
    "Upper Particles Group": GlobalKey(),
    "Lower Particles Group": GlobalKey(),
    "Manually overriding Z-Orders and SDFs": GlobalKey(),
  },

  SpecialDirectivesScreen.routeName: {
    "Special Directives": GlobalKey(),
    "Include": GlobalKey(),
    "Expand": GlobalKey(),
  },
  CreatingYourOwnShadersScreen.routeName: {
    "Creating your own Shaders": GlobalKey(),
    "Uniforms": GlobalKey(),
    "Minimal Fragment Shader Example; all Uniforms": GlobalKey(),
  },
  PipingScreen.routeName: {
    "Piping Data": GlobalKey(),
    "Supported Data Types": GlobalKey(),
    "Reloading Configurations": GlobalKey(),
  },
  CliArgsScreen.routeName: {"CLI Arguments": GlobalKey()},
};
