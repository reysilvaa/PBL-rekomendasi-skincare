import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A4BBA), Color(0xFF1257AA)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: SafeArea(
          top: false, // No top padding from SafeArea
          child: Stack(
            children: [
              // Decorative pattern on the right (optional)
              Positioned(
                right: -75,
                top: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.5,
                  child: Transform.scale(
                    scaleX: -1, // Flip the image horizontally
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/pattern.png', // Ensure this asset exists
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // Main content
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    50, 30, 50, 30), // Adjust bottom padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, $name',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "How's your day?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(imageUrl),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 20), // Space between greeting and button
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Align button to the right
                      children: [
                        const SizedBox(
                            width: 20), // Space to push the button right
                        ElevatedButton(
                          onPressed: () {
                            // Define your edit action here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize
                                .min, // Makes the button size fit the content
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center the content
                            children: const [
                              Icon(
                                Icons.edit, // Pencil icon
                                color: Color(0xFF1257AA), // Icon color
                                size: 24, // Adjust icon size as needed
                              ),
                              SizedBox(width: 8), // Space between icon and text
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Color(0xFF1257AA), // Button text color
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 80), // Maintain space where the search bar was
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
