@Library('libpipelines@master') _

def myOverrides = [
  BUILDTOOL_MEMORY_LIMIT: '6Gi',
  BUILDTOOL_MEMORY_REQUEST: '3Gi',]

hose {
    EMAIL = 'eos@stratio.com'
    BUILDTOOL_IMAGE = 'golang:1.17'
    BUILDTOOL = 'make'
    DEVTIMEOUT = 60
    DEPLOYONPRS = true
    ANCHORE_TEST = true
    VERSIONING_TYPE = 'stratioVersion-3-3'
    UPSTREAM_VERSION = '1.2.0'
    SKIPONPR = false

    DEV = { config ->
        doPackage(conf: config, parameters: "GOCACHE=/tmp", buildToolOverride: myOverrides)
        def SKIPONPR = false
        doDocker(conf: config, dockerfile: "rootfs/Dockerfile.stratio")
        doHelmChart(conf: config, helmTarget: "chart")
    }
}
