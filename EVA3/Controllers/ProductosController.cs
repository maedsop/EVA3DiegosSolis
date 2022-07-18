using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EVA3.Models;

namespace Tarea1.Controllers
{
    public class ProductosController : Controller
    {
        EVA3.Models.Tarea1Entities contexto = new EVA3.Models.Tarea1Entities();
        // GET: Productos
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Validar()
        {
            //Capturar los  valores del formulario
            var email = Request["email"];
            var pass = Request["password"];
            //Buscar los datos en la BD
            var usu = (from u in contexto.Usuario where u.email == email && u.pass == pass select u).FirstOrDefault();
            //Si existen Crear session con los datos
            if (usu != null)
            {
                Session["Usuario"] = usu;
                return RedirectToAction("Listar");
            }
            else
            {
                return RedirectToAction("Index");
            }
            //Si no redirecciono al Index con un mensaje

        }

        public ActionResult Listar()
        {
            if (Session["Usuario"] != null)
            {
                var prod = contexto.Producto.ToList();
                var cat = contexto.Categoria.ToList();
                ViewBag.Categorias = cat;
                return View(prod);
            }
            else
            {
                return RedirectToAction("Index");
            }
        }

        public ActionResult Eliminar(int id)
        {
            if (Session["Usuario"] != null)
            {
                var prod = (from p in contexto.Producto where p.Id == id select p).FirstOrDefault();

                string nombreImagen = prod.Imagen;

                contexto.Producto.Remove(prod);

                contexto.SaveChanges();

                //elimina la imagen desde el servidor
                string fullPath = Request.MapPath("~/Content/img/" + nombreImagen);
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }


                return RedirectToAction("Listar");
            }
            else
            {
                return RedirectToAction("Index");
            }
        }


        public ActionResult Guardar(HttpPostedFileBase imagen)
        {
            string mensaje = "";
            var id = Request["idProducto"];
            var nombre = Request["nombre"];
            var descripcion = Request["descripcion"];
            var precio = Request["precio"];
            var stock = Request["stock"];
            var idCategoria = Request["idCategoria"];
            string nombreImagen = "";

            if (imagen != null)
            {
                nombreImagen = id + imagen.FileName.Substring(imagen.FileName.IndexOf("."));

                string ruta = Path.Combine(Server.MapPath("~/Content/img"), Path.GetFileName(nombreImagen));
                imagen.SaveAs(ruta);
            }


            Producto p = new Producto();
            p.Id = int.Parse(id);
            p.Nombre = nombre;
            p.Descripcion = descripcion;
            p.Precio = int.Parse(precio);
            p.Stock = int.Parse(stock);
            p.IdCategoria = int.Parse(idCategoria);
            p.Imagen = nombreImagen;


            try
            {
                contexto.Producto.Add(p);
                contexto.SaveChanges();
                mensaje = "Guardado con exito";
            }
            catch (Exception ex)
            {
                mensaje = "Error al guardar el dato";
            }
            ViewBag.mensaje = mensaje;

            return RedirectToAction("Listar");
        }

        public ActionResult MostrarModificar(int id)
        {
            var prod = (from p in contexto.Producto where p.Id == id select p).FirstOrDefault();


            if (prod != null)
            {
                var cat = contexto.Categoria.ToList();
                ViewBag.Categorias = cat;
                return View(prod);
            }
            else
                return RedirectToAction("Listar");
        }

        public ActionResult GuardarModificar(HttpPostedFileBase imagen)
        {
            int id = int.Parse(Request["idProducto"]);
            var nombre = Request["nombre"];
            var descripcion = Request["descripcion"];
            var precio = Request["precio"];
            var stock = Request["stock"];
            var idCategoria = Request["idCategoria"];
            string nombreImagen = "";
            if (imagen != null)
            {
                nombreImagen = id + imagen.FileName.Substring(imagen.FileName.IndexOf("."));

                string ruta = Path.Combine(Server.MapPath("~/Content/img"), Path.GetFileName(nombreImagen));
                imagen.SaveAs(ruta);
            }

            Producto p = (from pro in contexto.Producto where pro.Id == id select pro).FirstOrDefault();
            if (p != null)
            {
                string nombreImagen2 = p.Imagen;
                if (imagen != null)
                {
                    string fullPath = Request.MapPath("~/Content/img/" + nombreImagen2);
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }

                    nombreImagen = id + imagen.FileName.Substring(imagen.FileName.IndexOf("."));
                    string ruta = Path.Combine(Server.MapPath("~/Content/img"), Path.GetFileName(nombreImagen));
                    imagen.SaveAs(ruta);
                }
                p.Nombre = nombre;
                p.Descripcion = descripcion;
                p.Precio = int.Parse(precio);
                p.Stock = int.Parse(stock);
                p.IdCategoria = int.Parse(idCategoria);
                p.Imagen = nombreImagen;
                contexto.SaveChanges();
            }

            return RedirectToAction("Listar");
        }
    }
}