class PwRtcNativeApi {
    companion object {
        init {
            System.loadLibrary("pwrtcsdkandroid")
        }
    }
    external fun getSignSecretKey(): String
}