allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

subprojects {
    configurations.all {
        resolutionStrategy {
            force("androidx.core:core:1.15.0")
            force("androidx.core:core-ktx:1.15.0")
            force("androidx.window:window:1.3.0")
            force("androidx.window:window-java:1.3.0")
        }
    }
}

// Universal Compile SDK Force:
// (Moved to manual patching of artifacts due to Flutter 3.4+ lifecycle conflicts)



tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
