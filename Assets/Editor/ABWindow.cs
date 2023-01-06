using System.IO;
using UnityEditor;
using UnityEngine;

namespace Editor
{
    public class ABWindow : EditorWindow
    {
        private string _path;

        [MenuItem("HungryTools/ab打包")]
        private static void ShowWindow()
        {
            var window = GetWindow<ABWindow>();
            window.titleContent = new GUIContent("AB包工具");
            window.maximized = true;
            window.maxSize = new Vector2(600, 600);
            window.Show();
        }

        private void OnGUI()
        {
            EditorGUILayout.HelpBox("运行时需要加载的资源需要分类好放在ArtRes文件夹下，框架会自动读取", MessageType.Info);
            EditorGUILayout.BeginHorizontal();
            {
                if (GUILayout.Button("快速打包"))
                {
                    if (Directory.Exists("Assets/ArtRes"))
                    {
                        DirectoryInfo directoryInfo = new DirectoryInfo("Assets/ArtRes");
                        DirectoryInfo[] folders = directoryInfo.GetDirectories();

                        foreach (var folder in folders)
                        {
                            Pack(folder.FullName);
                        }
                        EditorUtility.DisplayDialog("打包完成", $"已打包{folders.Length}个文件夹下的文件", "确定");
                        AssetDatabase.Refresh();
                    }
                }
            }
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.Space(20f);
            EditorGUILayout.BeginHorizontal();
            {
                GUILayout.Label("路径", GUILayout.Width(50f));
                _path = GUILayout.TextField(_path, GUILayout.Width(300f));
                if (GUILayout.Button("选择"))
                {
                    _path = EditorUtility.OpenFolderPanel("窗口标题", Application.dataPath, "");
                }

                if (GUILayout.Button("打包"))
                {
                    if (Directory.Exists(_path))
                    {
                        DirectoryInfo directoryInfo = new DirectoryInfo(_path);
                        DirectoryInfo[] folders = directoryInfo.GetDirectories();

                        foreach (var folder in folders)
                        {
                            Pack(folder.FullName);
                        }
                        EditorUtility.DisplayDialog("打包完成", $"已打包{folders.Length}个文件夹下的文件", "确定");
                        AssetDatabase.Refresh();
                    }
                }
            }
            EditorGUILayout.EndHorizontal();
        }

        private void Pack(string path)
        {
            if (!Directory.Exists(path))
                return;
            AssetBundleBuild[] buildMap = new AssetBundleBuild[1];
            string nowFolderName = path.Substring(path.LastIndexOf('\\') + 1);
            buildMap[0].assetBundleName = nowFolderName;

            DirectoryInfo directoryInfo = new DirectoryInfo(path);
            FileInfo[] files = directoryInfo.GetFiles("*", SearchOption.TopDirectoryOnly);

            string[] assetNames = new string[files.Length];
            for (var i = 0; i < files.Length; i++)
            {
                string fullPath = files[i].FullName;
                string relativePath = fullPath.Substring(fullPath.IndexOf("Assets"));
                relativePath = relativePath.Replace('\\', '/');
                assetNames[i] = relativePath;
            }

            buildMap[0].assetNames = assetNames;
            BuildPipeline.BuildAssetBundles("Assets/StreamingAssets", buildMap,
                BuildAssetBundleOptions.ChunkBasedCompression, BuildTarget.StandaloneWindows);
        }
    }
}