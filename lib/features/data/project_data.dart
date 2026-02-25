/// Model for project feature
class ProjectFeature {
  final String title;
  final String? description;

  ProjectFeature({required this.title, this.description});
}

/// Model for project stats
class ProjectStat {
  final String value;
  final String label;

  ProjectStat({required this.value, required this.label});
}

/// Model for project external links
class ProjectLink {
  final String label;
  final String url;
  final LinkType type;

  ProjectLink({required this.label, required this.url, required this.type});
}

enum LinkType { github, demo, website }

/// Complete project model
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final List<ProjectFeature> features;
  final List<String> technologies;
  final List<ProjectStat> stats;
  final List<ProjectLink> links;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.features,
    required this.technologies,
    required this.stats,
    required this.links,
  });
}

// Sample ClassTracking Project Data
final classTrackingProject = ProjectModel(
  id: 'class_tracking',
  title: 'Class Tracking System',
  description:
      'A comprehensive class management and tracking system designed to help educators and students keep track of attendance, grades, and course progress in real-time.',
  imageAsset: 'assets/images/class_tracking.png',
  features: [
    ProjectFeature(title: 'Real-time attendance tracking'),
    ProjectFeature(title: 'Automated grade calculation'),
    ProjectFeature(title: 'Student progress monitoring'),
    ProjectFeature(title: 'Parent notification system'),
    ProjectFeature(title: 'Mobile app support'),
    ProjectFeature(title: 'Cloud-based storage'),
  ],
  technologies: ['Flutter', 'Firebase', 'Dart', 'REST API'],
  stats: [
    ProjectStat(value: '2023', label: 'Year Started'),
    ProjectStat(value: '500+', label: 'Users'),
    ProjectStat(value: '4.8', label: 'Rating'),
  ],
  links: [
    ProjectLink(
      label: 'GitHub',
      url: 'https://github.com/yourusername/class-tracking',
      type: LinkType.github,
    ),
    ProjectLink(
      label: 'Live Demo',
      url: 'https://demo.classTracking.app',
      type: LinkType.demo,
    ),
  ],
);
