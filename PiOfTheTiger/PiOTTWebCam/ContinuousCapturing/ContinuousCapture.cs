﻿using EmailUtils;
using PictureUtils;
using PiOTTDAL.Constants;
using PiOTTDAL.Entities;
using PiOTTDAL.Queries;
using PiOTTWebCam.CaptureImages;
using RaspberryCam;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace PiOTTWebCam.ContinuousCapturing
{
    public class ContinuousCapture
    {
        private Cameras cameras;
        private CamManagerBuilder camBuilder;
        private List<Camera> availableCameras;
        private Timer timer;
        private string picturesFolder;
        private string processedPicturesFolder;

        public ContinuousCapture()
        {
            InitializeCameras();

            InitializeTimer();

            picturesFolder = new AppSettingsQuery().GetAppSettingByKey(QueryConstants.AppSettingsKey_PicturesSavePath);
            processedPicturesFolder = new AppSettingsQuery().GetAppSettingByKey(QueryConstants.AppSettingsKey_ProcessedPicturesSavePath);

            if (!Directory.Exists(processedPicturesFolder))
                Directory.CreateDirectory(processedPicturesFolder);
        }

        private void InitializeTimer()
        {
            timer = new Timer();

            string interval = new AppSettingsQuery().GetAppSettingByKey(QueryConstants.AppSettingsKey_PicturesSaveInterval);

            timer.Interval = Double.Parse(interval);
            timer.Elapsed += timer_Elapsed;
        }

        void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            timer.Stop();
            foreach(Camera cam in availableCameras)
            {
                new CaptureImage().TakePicture(cam, cameras);

                CompareTakenPictures(cam);
            }

            string interval = new AppSettingsQuery().GetAppSettingByKey(QueryConstants.AppSettingsKey_PicturesSaveInterval);
            Double actualInterval = Double.Parse(interval);

            if (actualInterval != timer.Interval)
            {
                //timer.Stop();
                timer.Interval = actualInterval;
                //timer.Start();
            }

            timer.Start();
        }

        private void CompareTakenPictures(Camera cam)
        {
            string path = Path.Combine(picturesFolder, cam.CameraName);
            Console.WriteLine(path);

            List<String> files = Directory.EnumerateFiles(path).ToList();

            if (files.Count > 2)
            {
                foreach (string file in files)
                {
                    File.Delete(file);
                }
                Console.WriteLine("Files deleted");
            }
            else if (files.Count == 2)
            {
                Console.WriteLine("We have 2 files");
                FileInfo file0 = new FileInfo(files[0]);
                FileInfo file1 = new FileInfo(files[1]);

                if (file0.CreationTime > file1.CreationTime)
                {
                    file0 = new FileInfo(files[1]);
                    file1 = new FileInfo(files[0]);
                }

                Console.WriteLine(String.Format("File {0} is newer than file {1}", file1.FullName, file0.FullName));

                Bitmap bitmap = ImageComparer.Compare(file0.FullName, file1.FullName);
                Console.WriteLine("Compare finished");

                if (bitmap != null)
                {
                    string diffSaveFullPath = Path.Combine(processedPicturesFolder, String.Format("{0}_Differences.jpg", Path.GetFileNameWithoutExtension(file1.FullName)));
                    Console.WriteLine(diffSaveFullPath);
                    bitmap.Save(diffSaveFullPath);
                    new EmailCreator().SendMailForDifferentImages(file1.FullName, diffSaveFullPath);
                }

                File.Delete(file0.FullName);
            }
        }

        private void InitializeCameras()
        {
            availableCameras = new CameraQuery().GetAllCamera();
            camBuilder = Cameras.DeclareDevice().Named(availableCameras[0].CameraName).WithDevicePath(availableCameras[0].Path);

            foreach (Camera camera in availableCameras.Skip(1))
            {
                camBuilder.AndDevice().Named(camera.CameraName).WithDevicePath(camera.Path);
            }

            cameras = camBuilder.Memorize();
        }

        public void StartCapturing()
        {
            timer.Start();
        }
    }
}
