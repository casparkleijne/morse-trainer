# Morse Code Trainer!

A retro-styled morse code learning application using the Koch method, built with Godot 4.5. Features an authentic 8-bit aesthetic with ANSI color palette and pixel-perfect rendering.

## Features

### Learning Method
- **Koch Method Implementation**: Progressive learning system that introduces morse code characters one at a time
- **Incremental Difficulty**: Start with two characters and gradually expand your repertoire
- **Spaced Repetition**: Reinforces learning through strategic character introduction timing
- **Audio Training**: Learn to recognize morse code by ear, the most effective learning method

### Technical Features
- **Retro 8-bit Aesthetic**: Authentic pixel-perfect rendering with integer scaling
- **ANSI Color Palette**: Classic terminal colors for nostalgic visual appeal
- **Mobile-Ready**: Optimized for iPhone development with portrait orientation
- **Reusable UI Components**: Modular design system with RetroCard, RetroButton, and RetroGrid components
- **Cross-Platform**: Built with Godot 4.5 for deployment to web, mobile, and desktop

### Dual Implementation
- **Web Version**: Browser-based implementation for instant access
- **Godot Version**: Native application with enhanced features and offline capability

## Technology Stack

- **Engine**: Godot 4.5
- **Language**: GDScript
- **Target Platforms**: iOS (iPhone), Web, Desktop
- **Display**: 320×568 base resolution with integer scaling
- **Audio**: Built-in tone generation for morse code playback

## Screen Resolution

The application is optimized for mobile development, particularly iPhone:

- **Base Resolution**: 320×568 (retro-friendly, scales perfectly to modern displays)
- **Stretch Mode**: canvas_items with integer scaling for pixel-perfect rendering
- **Aspect Ratio**: Portrait orientation with safe area handling for notch/Dynamic Island
- **Scaling**: 3-4× upscaling to modern iPhone resolutions while maintaining crisp pixels

## UI Component System

The application uses a modular component architecture

All components share the same four-level wrapper structure for visual consistency across the application.

## Koch Method

The Koch method is the most effective technique for learning morse code:

1. **Start with K and M**: Learn to recognize just two characters at full speed (20 WPM)
2. **Add Characters Gradually**: Introduce one new character at a time
3. **Maintain Speed**: Always practice at target speed, never slow down
4. **Ear Training**: Focus on sound recognition rather than visual memorization
5. **Progressive Mastery**: Only advance when achieving 90% accuracy

Standard Koch sequence: K M R S U A P T L O W I . N J E F 0 Y , V G 5 / Q 9 Z H 3 8 B ? 4 2 7 C 1 D 6 X

## Installation

### Prerequisites
- Godot 4.5 or later
- For iOS builds: macOS with Xcode installed
- For web builds: Godot export templates

### Setup
```bash
git clone https://github.com/casparkleijne/morse-trainer.git
cd morse-trainer
```

Open the project in Godot 4.5+ and run with F5.

### Building for iOS
1. Install iOS export templates in Godot
2. Configure signing in Project → Export
3. Export → iOS
4. Deploy via Xcode

### Building for Web
1. Install web export templates
2. Export → HTML5
3. Deploy to web server or GitHub Pages


## Usage

### Starting Training
1. Launch the application
2. Select "Start Training" from the main menu
3. Listen to the morse code tones
4. Type the characters you hear
5. Receive immediate feedback

### Progression
- Begin with K and M
- Achieve 90% accuracy before new characters are introduced
- Practice in sessions of 10-20 minutes for best retention
- Speed remains constant at 20 WPM (standard Koch method)

### Customization
- Adjust tone frequency (default: 600 Hz)
- Modify character spacing
- Toggle visual feedback
- Configure session length

## Development

### Component Development
The modular component system allows for easy UI development:

```gdscript
# Creating a new screen using components
extends VBoxContainer

func _ready():
    var card = preload("res://scenes/components/retro_card.tscn").instantiate()
    var button = preload("res://scenes/components/retro_button.tscn").instantiate()
    
    button.set_text("START")
    button.pressed.connect(_on_start_pressed)
    
    add_child(card)
    card.content.add_child(button)
```

### Adding New Features
1. Create new components by inheriting from RetroCard
2. Maintain the four-level wrapper structure for consistency
3. Use ANSI color palette for theming
4. Test on target resolution (320×568)

### Code Style
- Use GDScript type hints
- Follow Godot naming conventions
- Comment complex algorithms
- Keep functions focused and single-purpose

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines
- Maintain the retro aesthetic
- Follow the existing component architecture
- Test on both mobile and desktop
- Update documentation for new features
- Ensure pixel-perfect rendering is maintained

## License

This project is open source and available under the MIT License.

## Acknowledgments

- **Koch Method**: Developed by German psychologist Ludwig Koch in the 1930s
- **ANSI Colors**: Classic terminal color palette from the ANSI standard
- **Godot Engine**: Open source game engine used for development
- **Morse Code**: Communication system developed by Samuel Morse and Alfred Vail

## Roadmap

### Planned Features
- [ ] Progress tracking and statistics
- [ ] Multiple difficulty modes (beginner, standard, expert)
- [ ] Custom character sequences
- [ ] Multiplayer practice mode
- [ ] Achievement system
- [ ] Cloud sync for progress
- [ ] Additional language support
- [ ] Prosigns training (AR, SK, BT, etc.)
- [ ] Word recognition mode
- [ ] Callsign practice for amateur radio

### Technical Improvements
- [ ] Accessibility features (screen reader support)
- [ ] Gamepad/controller support
- [ ] Customizable key bindings
- [ ] Performance optimizations for older devices
- [ ] Automated testing suite

## Support

For bugs, feature requests, or questions:
- Open an issue on GitHub
- Contact: [Your contact information]

## Author

**Caspar Kleijne**
- GitHub: [@casparkleijne](https://github.com/casparkleijne)
- Role: Independent contractor (ZZP) specializing in enterprise architecture and technical development

## Additional Resources

- [Koch Method Details](https://www.longislandcwclub.org/koch-method/)
- [Morse Code Reference](https://en.wikipedia.org/wiki/Morse_code)
- [Godot Documentation](https://docs.godotengine.org/)
- [ANSI Color Standards](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors)

---

**Status**: Active Development 🚧

Last Updated: November 2025
