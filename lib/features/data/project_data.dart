

/// Model for project feature
class ProjectFeature {
  final String title;
  final String? description;

  ProjectFeature({required this.title, this.description});

  factory ProjectFeature.fromJson(Map<String, dynamic> json) {
    return ProjectFeature(
      title: json['title'] as String,
      description: json['description'] as String?,
    );
  }
}

/// Model for project stats
class ProjectStat {
  final String value;
  final String label;

  ProjectStat({required this.value, required this.label});

  factory ProjectStat.fromJson(Map<String, dynamic> json) {
    return ProjectStat(
      value: json['value'] as String,
      label: json['label'] as String,
    );
  }
}

/// Model for project external links
class ProjectLink {
  final String label;
  final String url;
  final LinkType type;

  ProjectLink({required this.label, required this.url, required this.type});

  factory ProjectLink.fromJson(Map<String, dynamic> json) {
    return ProjectLink(
      label: json['label'] as String,
      url: json['url'] as String,
      type: _parseLinkType(json['type'] as String),
    );
  }
}

enum LinkType { github, demo, website }

LinkType _parseLinkType(String type) {
  return LinkType.values.firstWhere(
    (e) => e.toString().split('.').last == type,
    orElse: () => LinkType.github,
  );
}

/// Model for project image
class ProjectImage {
  final String url;
  final String label;

  ProjectImage({required this.url, required this.label});
}

/// Complete project model
class ProjectModel {
  final String id; // iteam_01, iteam_02, etc.
  final String imageAsset; // Main hero image URL
  final List<ProjectImage> images; // Additional images
  final List<ProjectLink> links;

  ProjectModel({
    required this.id,
    required this.imageAsset,
    this.images = const [],
    this.links = const [],
  });
}

/// Load all projects from app_images
List<ProjectModel> getAllProjectsData() {
  return [
    ProjectModel(
      id: 'iteam_01',
      imageAsset: 'https://raw.githubusercontent.com/kittanai46/images_for_app/one_profile/assets/class_tracking.png',
      images: [
        ProjectImage(
          url: 'https://raw.githubusercontent.com/kittanai46/images_for_app/one_profile/assets/class_tracking_page.png',
          label: 'Application Interface',
        ),
      ],
      links: [
        ProjectLink(
          label: 'GitHub Repository',
          url: 'https://github.com/kittanai46/class_tracking',
          type: LinkType.github,
        ),
        ProjectLink(
          label: 'Live Demo',
          url: 'https://example.com/class-tracking-demo',
          type: LinkType.demo,
        ),
      ],
    ),
    ProjectModel(
      id: 'iteam_02',
      imageAsset: 'https://raw.githubusercontent.com/kittanai46/images_for_app/one_profile/assets/wpfIcon.png',
      images: [
        ProjectImage(
          url: 'https://raw.githubusercontent.com/kittanai46/images_for_app/one_profile/assets/wpf_page.png',
          label: 'Desktop Interface',
        ),
      ],
      links: [
        ProjectLink(
          label: 'GitHub Repository',
          url: 'https://github.com/kittanai46/wpf-vtm',
          type: LinkType.github,
        ),
      ],
    ),
    ProjectModel(
      id: 'iteam_03',
      imageAsset: 'https://raw.githubusercontent.com/kittanai46/images_for_app/one_profile/assets/automationIcon.png',
      images: [],
      links: [
        ProjectLink(
          label: 'GitHub Repository',
          url: 'https://github.com/kittanai46/automation-tests',
          type: LinkType.github,
        ),
      ],
    ),
    ProjectModel(
      id: 'iteam_04',
      imageAsset: 'https://raw.githubusercontent.com/kittanai46/images_for_app/one_profile/assets/backofficeIcon.png',
      images: [],
      links: [
        ProjectLink(
          label: 'GitHub Repository',
          url: 'https://github.com/kittanai46/backoffice',
          type: LinkType.github,
        ),
        ProjectLink(
          label: 'Live System',
          url: 'https://backoffice-example.com',
          type: LinkType.demo,
        ),
      ],
    ),
  ];
}

// Cached projects
List<ProjectModel>? _cachedProjects;

Future<List<ProjectModel>> getAllProjects() async {
  _cachedProjects ??= getAllProjectsData();
  return _cachedProjects!;
}

Future<ProjectModel?> getProjectById(String id) async {
  final projects = await getAllProjects();
  return projects.cast<ProjectModel?>().firstWhere(
        (project) => project?.id == id,
        orElse: () => null,
      );
}
