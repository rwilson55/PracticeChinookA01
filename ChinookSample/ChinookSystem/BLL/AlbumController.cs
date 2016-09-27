using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additonal Namespaces
using System.Data.Entity;
using ChinookSystem.Data.Entities;
using ChinookSystem.Data.POCOs;
using ChinookSystem.DAL;
using System.ComponentModel;
#endregion
namespace ChinookSystem.BLL
{
    [DataObject]
    public class AlbumController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Artist> Artist_ListAll()
        {
            using (var context = new ChinookContext())
            {
                return context.Artists.ToList();
            }
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ArtistAlbums> ArtistAlbums()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Albums
                              where x.ReleaseYear == 2008
                              orderby x.Artists.Name, x.Title
                              select new ArtistAlbums
                              {
                                  Name = x.Artists.Name,
                                  Title = x.Title
                              };
                return results.ToList();
            }
        }

        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public List<WaiterOnDuty> ListWaiters()
        //{
        //    using (eRestaurantContext context = new eRestaurantContext())
        //    {
        //        var result = from person in context.Waiters
        //                     where person.ReleaseDate == null
        //                     select new WaiterOnDuty()
        //                     {
        //                         WaiterId = person.WaiterID,
        //                         FullName = person.FirstName + " " + person.LastName
        //                     };
        //        return result.ToList();
        //    }
        //}
    }
}
