using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additonal Namespaces
using System.ComponentModel; //ODS
using ChinookSystem.Data.Entities;
using ChinookSystem.Data.POCOs;
using ChinookSystem.DAL;
#endregion

namespace ChinookSystem.BLL
{
    [DataObject]
    public class TrackController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Track> List_Tracks()
        {
            using (var context = new ChinookContext())
            {
                //return all records, all attributes
                return context.Tracks.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Track Get_Track(int trackid)
        {
            using (var context = new ChinookContext())
            {
                //return a record, all attributes
                return context.Tracks.Find(trackid);
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public void Add_Track(Track trackinfo)
        {
            using (var context = new ChinookContext())
            {
                //any business rules
                //if (trackinfo.UnitPrice > 1.0m)
                //{
                //    throw new Exception("Bob's your uncle");
                //}

                //any data refinements
                //review of using Iif
                //composer can be a null string
                //we do not wish to store an empty string
                trackinfo.Composer = string.IsNullOrEmpty(trackinfo.Composer) ? null : trackinfo.Composer;

                //add the instance of trackinfo to the database
                context.Tracks.Add(trackinfo);

                //commit of the transaction
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public void Update_Track(Track trackinfo)
        {
            using (var context = new ChinookContext())
            {
                //any business rules

                //any data refinements
                //review of using Iif
                //composer can be a null string
                //we do not wish to store an empty string
                trackinfo.Composer = string.IsNullOrEmpty(trackinfo.Composer) ? null : trackinfo.Composer;

                //update the existing instance of trackinfo in the database
                context.Entry(trackinfo).State = System.Data.Entity.EntityState.Modified;

                //commit of the transaction
                context.SaveChanges();
            }
        }

        //the delete is an overloaded method technique

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public void Delete_Track(Track trackinfo)
        {
            Delete_Track(trackinfo.TrackId);
        }

        public void Delete_Track(int trackid)
        {
            using (var context = new ChinookContext())
            {
                //any business rules

                //do the delete
                //find the existing record on the database
                var existing = context.Tracks.Find(trackid);
                //delete the record from the database
                context.Tracks.Remove(existing);
                //commit the transaction
                context.SaveChanges();
            }
        }
    }
}
